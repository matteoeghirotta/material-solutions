module Msg exposing (..)

import Url exposing (Url)
import Browser

type Msg
    = ToggleMenu
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
