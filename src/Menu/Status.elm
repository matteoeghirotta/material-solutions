module Menu.Status exposing (..)

type Status
    = Active
    | Hidden

toString : Status -> String
toString status =
    case status of
        Active -> "active"
        Hidden -> "hidden"                  

toggle : Status -> Status
toggle status =
    case status of
        Active -> Hidden
        Hidden -> Active
