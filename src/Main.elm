module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Url exposing (Url)
import Html exposing (Html)
import Msg exposing (..)
import Header
import Menu
import Menu.Status
import Page


---- MODEL ----


type alias Model =
    { header : Header.Header
    , menu   : Menu.Menu
    , page   : Page.Page
    , key    : Nav.Key
    , url    : Url.Url
    }
             
init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey=
    ( { header = { headerClass = "logo" }
      , menu   = { entries = [ "Products"
                             , "People"
                             , "Contacts"
                             ]
                 , status = Menu.Status.Hidden
                 }
      , page = Page.Home
      , url = url
      , key = navKey
      }
    , Cmd.none
    )


---- UPDATE ----
      

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

        ToggleMenu ->
            let oldMenu = model.menu
                menu = { oldMenu | status = Menu.Status.toggle oldMenu.status }
            in
                ( { model | header = Header.toggle model.header
                          , menu = menu
                  }
                , Cmd.none
                )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->                    
                    let page =
                            case (Url.toString url) of
                                "Home"     -> Page.Home
                                "Products" -> Page.Products
                                "People"   -> Page.People
                                "Contacts" -> Page.Contacts
                                _          -> -- Debug.log ("URL: " ++ (Url.toString url)) 
                                              Page.Home
                    in
                    ( model, Nav.pushUrl model.key (Url.toString url) )
                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let page =
                    Page.match url
            in
                case page of
                    Just newPage ->
                        ( { model | url = url, page = newPage }
                        , Cmd.none
                        )
                    Nothing ->
                        ( { model | url = url, page = Page.Home }
                        , Cmd.none
                        )


---- VIEW ----


view : Model -> Html Msg
view model =
    Page.render model.page model.header model.menu
        

---- PROGRAM ----

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = always Sub.none
        , update = update
        , view = \model -> { title = "Material • Solutions"
                           , body = [view model]
                           }
        }

