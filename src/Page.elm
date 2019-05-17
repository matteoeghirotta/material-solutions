module Page exposing (..)

import Url exposing (Url)
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string, top)
import Html exposing (Html)
import Msg exposing (..)
import Header
import Menu
import Menu.Status
import Page.Home
import Page.Products
import Page.People
import Page.Contacts

type Page
    = Home
    | Products
    | People
    | Contacts

render : Page -> Header.Header -> Menu.Menu -> Html Msg
render page header menu =
    case page of
        Home     -> Page.Home.render header menu
        Products -> Page.Products.render header menu
        People   -> Page.People.render header menu
        Contacts -> Page.Contacts.render header menu

routeParser : Parser (Page -> a) a
routeParser =
  oneOf
    [ map Home     top
    , map Products (s "Products")
    , map People   (s "People")
    , map Contacts (s "Contacts")
    ]

match : Url -> Maybe Page
match url =
    Url.Parser.parse routeParser url
