module View exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Form
import Html
import Html.Attributes as Html
import Html.Events as Html
import Model
import Msg


view : Model.Model -> Html.Html Msg.Msg
view model =
    Form.form [] (renderTool model.dropdownState model.patients model.selectedPatient)


renderTool : Dropdown.State -> List Model.Patient -> Maybe Model.Patient -> List (Html.Html Msg.Msg)
renderTool state pts maybePt =
    case maybePt of
        Nothing ->
            [ renderDropdown state pts ]

        Just pt ->
            [ renderDropdown state pts
            , renderNotesSection maybePt
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


renderNotesSection : Maybe Model.Patient -> Html.Html Msg.Msg
renderNotesSection maybePt =
    let
        preexistingNote =
            case maybePt of
                Just pt ->
                    pt.patientNote

                Nothing ->
                    ""
    in
    Form.text
        [ Form.id "patientNotes"
        , Form.large
        , Form.value preexistingNote
        , Form.onInput Msg.PatientNote
        ]
