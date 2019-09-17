module View exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.Textarea as Form
import Html
import Html.Attributes as Html
import Html.Events as Html
import Model
import Msg
import Time


view : Model.Model -> Html.Html Msg.Msg
view model =
    Form.form [] (renderTool model)


renderTool : Model.Model -> List (Html.Html Msg.Msg)
renderTool model =
    let
        showNewPatientForm =
            if model.showNewPatientForm == True then
                [ renderAddNewPatientInput model.newPatientToAdd.patientName, renderAddNewPatientButton model.newPatientToAdd ]

            else
                []

        disableStartButton =
            if model.timerState == Model.Running then
                -- should make these Bools into newtypes so they don't get confused
                True

            else
                False

        resTime =
            -- If the selected patient has a result time > 0, display that, otherwise display the
            -- resultTime
            case model.selectedPatient of
                Nothing ->
                    model.resultTime

                Just pt ->
                    if pt.patientSeconds > 0 then
                        Time.millisToPosix pt.patientSeconds

                    else
                        model.resultTime
    in
    case model.selectedPatient of
        Nothing ->
            [ renderDropdown model.dropdownState model.patients
            , renderShowNewPatientFormButton
            , Html.div [] showNewPatientForm
            ]

        Just pt ->
            [ renderDropdown model.dropdownState model.patients
            , renderShowNewPatientFormButton
            , Html.div [] showNewPatientForm

            -- All of this form stuff should be in an HTML form element
            , renderNotesSection pt
            , renderSubmitButton pt
            , renderTimer resTime disableStartButton (not disableStartButton)
            ]



-- DROPDOWN


renderDropdown : Dropdown.State -> List Model.Patient -> Html.Html Msg.Msg
renderDropdown state pts =
    Dropdown.dropdown
        state
        { options = [ Dropdown.alignMenuRight ]
        , toggleMsg = Msg.DropdownMsg
        , toggleButton =
            Dropdown.toggle [ Button.large, Button.outlinePrimary ] [ Html.text "Select Patient" ]
        , items = populateDropdown pts
        }


populateDropdown : List Model.Patient -> List (Dropdown.DropdownItem Msg.Msg)
populateDropdown pts =
    List.map
        (\pt ->
            Dropdown.buttonItem [ Html.onClick <| Msg.SelectedPatient pt ]
                [ Html.text <| Model.patientNameToString pt.patientName ]
        )
        pts



-- NOTES


renderNotesSection : Model.Patient -> Html.Html Msg.Msg
renderNotesSection pt =
    Form.textarea
        [ Form.id "patientNotes"
        , Form.rows 5
        , Form.value pt.patientNote
        , Form.onInput Msg.PatientNote
        ]



-- SUBMIT BUTTON


renderSubmitButton : Model.Patient -> Html.Html Msg.Msg
renderSubmitButton pt =
    Button.submitButton
        [ Button.primary
        , Button.large
        , Button.onClick <| Msg.SubmitUpdatePatientForm pt
        ]
        [ Html.text "Submit" ]



-- TIMER


renderTimer : Time.Posix -> Bool -> Bool -> Html.Html Msg.Msg
renderTimer timerDisplay disableStartButton disabledStopButton =
    Html.div []
        [ renderStartButton disableStartButton
        , renderStopButton disabledStopButton
        , Html.h1 [] [ Html.text <| String.fromInt <| Time.posixToMillis timerDisplay ]
        ]


renderStartButton : Bool -> Html.Html Msg.Msg
renderStartButton disableButton =
    Button.button
        [ Button.success
        , Button.large
        , Button.onClick <| Msg.StartTimer
        , Button.disabled disableButton
        ]
        [ Html.text "Start Timer" ]


renderStopButton : Bool -> Html.Html Msg.Msg
renderStopButton disableButton =
    Button.button
        [ Button.danger
        , Button.large
        , Button.onClick <| Msg.StopTimer
        , Button.disabled disableButton
        ]
        [ Html.text "Stop Timer" ]



-- ADD NEW PATIENT


renderShowNewPatientFormButton : Html.Html Msg.Msg
renderShowNewPatientFormButton =
    Button.button
        [ Button.outlineDark
        , Button.large
        , Button.onClick Msg.ShowNewPatientForm
        ]
        [ Html.text "Show 'New Patient' Form" ]


renderAddNewPatientInput : Model.PatientName -> Html.Html Msg.Msg
renderAddNewPatientInput ptName =
    Input.text
        [ Input.id "newPatientName"
        , Input.onInput Msg.NewPatientName
        , Input.value <| Model.patientNameToString ptName
        ]


renderAddNewPatientButton : Model.Patient -> Html.Html Msg.Msg
renderAddNewPatientButton pt =
    Button.submitButton
        [ Button.primary
        , Button.small
        , Button.onClick <| Msg.SubmitNewPatientForm pt
        ]
        [ Html.text "Add New Patient" ]
