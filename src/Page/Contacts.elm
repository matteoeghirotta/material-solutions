module Page.Contacts exposing (..)

import Msg exposing (..)
import Html exposing (Html, text, div, h1, img, ul, li, p)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)
import Header
import Menu
import Menu.Status

render : Header.Header -> Menu.Menu -> Html Msg
render header menu =
    div []
        [ div [ class "header" ]
              [ img [ class header.headerClass
                    -- , src "/ms_logo.png" -- with production build dnw
                    , src "./ms_logo.png"
                    , onClick ToggleMenu
                    ] []
              , h1 [] [ text "Material Solutions" ]
              ]
        , Menu.toHtml menu
        , div [ class "content" ]
            [ p [] [text "Contacts"]             
            ]
        ]
