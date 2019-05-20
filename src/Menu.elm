module Menu exposing (Menu, toHtml)

import Menu.Status exposing (..)
import Msg  exposing (..)
import Html exposing (Html, text, ul, li, a, div)
import Html.Attributes exposing (class, href)
              
type alias Menu =
    { entries : List String
    , status  : Status
    }

toLi : String -> Html Msg
toLi name = li [] [ a [ href ("#" ++ name) ] [ text name ] ]

toHtml : Menu -> Html Msg
toHtml menu =
    div [ class ("menu " ++ (toString menu.status)) ]
        [ ul [ class (toString menu.status) ]
              (List.map (\entry -> toLi entry) menu.entries)
        ]
