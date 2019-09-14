module View exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Html
import Html.Attributes as Html
import Model
import Msg


view : Dropdown.State -> Model.Model -> Html.Html Msg.Msg
view dropdownState model =
    -- It seems bad to pass in Dropdown.State but I'm not going to take the time now to figure it out.
    let
        output =
            case model of
                Model.Failure ->
                    Html.text "Failure"

                Model.Loading ->
                    Html.text "Loading..."

                Model.Success pts ->
                    renderPatients pts
    in
    Html.div [] [ renderDropdown dropdownState, output ]


renderDropdown : Dropdown.State -> Html.Html Msg.Msg
renderDropdown state =
    Dropdown.dropdown
        state
        { options = [ Dropdown.alignMenuRight ]
        , toggleMsg = Msg.DropdownMsg
        , toggleButton =
            Dropdown.toggle [ Button.warning ] [ Html.text "MyDropdown1" ]
        , items =
            [ Dropdown.divider
            , Dropdown.header [ Html.text "Silly items" ]
            , Dropdown.buttonItem [ Html.class "disabled" ] [ Html.text "DoNothing1" ]
            , Dropdown.buttonItem [] [ Html.text "DoNothing2" ]
            ]
        }


renderPatients : List Model.Patient -> Html.Html msg
renderPatients pts =
    -- TODO use dropdown to render names
    let
        maybePt =
            List.head pts
    in
    case maybePt of
        Just pt ->
            Html.div [] [ Html.text <| "Names: " ++ Model.patientNameToString pt.patientName ]

        Nothing ->
            Html.div [] []
