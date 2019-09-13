{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Main
  ( main
  )
where

import qualified Control.Monad.Logger    as Logger
import qualified Data.Aeson              as Aeson
import qualified Data.Text               as T
import qualified Database.Persist.Sqlite as Sql
import qualified Database.Persist.TH     as TH
import qualified Web.Spock               as Spock
import qualified Web.Spock.Config        as SpockCfg


type Api = Spock.SpockM Sql.SqlBackend () ()

type ApiAction a = Spock.SpockAction Sql.SqlBackend () () a

type PatientName = T.Text

type PatientNote = T.Text

type PatientTime = Int

TH.share [TH.mkPersist TH.sqlSettings, TH.mkMigrate "migrateAll"] [TH.persistLowerCase|
Patient json
  name PatientName
  note PatientNote
  time PatientTime
  deriving Show
|]

main :: IO ()
main = do
  pool <- Logger.runStdoutLoggingT
    $ Sql.createSqlitePool "ten_meter_walk_results" 5
  cfg <- SpockCfg.defaultSpockCfg () (SpockCfg.PCPool pool) ()
  Logger.runStdoutLoggingT
    $ Sql.runSqlPool (Sql.runMigrationUnsafe migrateAll) pool
  Spock.runSpock 8080 (Spock.spock cfg routes)

runSql
  :: (Spock.HasSpock m, Spock.SpockConn m ~ Sql.SqlBackend)
  => Sql.SqlPersistT (Logger.LoggingT IO) a
  -> m a
runSql action = Spock.runQuery
  $ \conn -> Logger.runStdoutLoggingT $ Sql.runSqlConn action conn

routes :: Api ()
routes = do
  Spock.get "patients" $ do
    pts <- runSql $ Sql.selectList [] [Sql.Asc PatientId]
    Spock.json pts

  Spock.get ("patients" Spock.<//> Spock.var) $ \ptId -> do
    maybePt <- runSql $ Sql.get ptId :: ApiAction (Maybe Patient)
    case maybePt of
      Nothing -> errorJson 2 "Could not find patient"
      Just pt -> Spock.json pt

  Spock.put ("patients" Spock.<//> Spock.var) $ \ptId -> do
    maybePt <- Spock.jsonBody' :: ApiAction (Maybe Patient)
    case maybePt of
      Nothing -> errorJson 1 "Failed to parse request body as Patient"
      Just pt -> do
        id' <- runSql $ Sql.replace ptId pt
        Spock.json $ Aeson.object
          ["result" Aeson..= Aeson.String "success", "id" Aeson..= id']

  Spock.post "patients" $ do
    maybePt <- Spock.jsonBody' :: ApiAction (Maybe Patient)
    case maybePt of
      Nothing -> errorJson 1 "Failed to parse request body as Patient"
      Just pt -> do
        newId <- runSql $ Sql.insert pt
        Spock.json $ Aeson.object
          ["result" Aeson..= Aeson.String "success", "id" Aeson..= newId]

errorJson :: Int -> T.Text -> ApiAction ()
errorJson code message = Spock.json $ Aeson.object
  [ "result" Aeson..= Aeson.String "failure"
  , "error"
    Aeson..= Aeson.object ["code" Aeson..= code, "message" Aeson..= message]
  ]
