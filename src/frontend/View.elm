module View exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Bootstrap.Form as Form
import Bootstrap.Form.Textarea as Form
import Html
import Html.Attributes as Html
import Html.Events as Html
import Model
import Msg


view : Model.Model -> Html.Html Msg.Msg
view model =
    Form.form [] (renderTool model)


renderTool : Model.Model -> List (Html.Html Msg.Msg)
renderTool model =
    case model.selectedPatient of
        Nothing ->
            [ renderDropdown model.dropdownState model.patients ]

        Just pt ->
            [ renderDropdown model.dropdownState model.patients
            , renderNotesSection pt
            , renderSubmitButton pt
            ]



-- DROPDOWN


renderDropdown : Dropdown.State -> List Model.Patient -> Html.Html Msg.Msg
renderDropdown state pts =
    Dropdown.dropdown
        state
        { options = [ Dropdown.alignMenuRight ]
        , toggleMsg = Msg.DropdownMsg
        , toggleButton =
            Dropdown.toggle [ Button.large ] [ Html.text "MyDropdown1" ]
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
        , Button.onClick <| Msg.SubmitForm pt
        ]
        [ Html.text "Submit" ]
