module Header exposing (..)

type alias Header =
    { headerClass : String }

toggle : Header -> Header
toggle model =
    case model.headerClass of
        "logo" -> { model | headerClass = "clicked" }
        "clicked" -> { model | headerClass = "logo" }
        _ -> model
