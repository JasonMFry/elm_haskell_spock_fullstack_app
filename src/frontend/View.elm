module View exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Html
import Html.Attributes as Html
import Model
import Msg


view : Model.Model -> Html.Html Msg.Msg
view model =
    let
        output =
            case model of
                Model.Failure ->
                    Html.text "Failure"

                Model.Loading ->
                    Html.text "Loading..."

                Model.Success ( pts, dropdownState ) ->
                    renderDropdown dropdownState pts
    in
    Html.div [] [ output ]


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


populateDropdown : List Model.Patient -> List (Dropdown.DropdownItem msg)
populateDropdown pts =
    List.map
        (\pt ->
            Dropdown.buttonItem []
                [ Html.text <| Model.patientNameToString pt.patientName ]
        )
        pts
