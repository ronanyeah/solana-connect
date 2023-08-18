port module Ports exposing (..)


port disconnect : Bool -> Cmd msg


port close : () -> Cmd msg


port connect : String -> Cmd msg


port copy : String -> Cmd msg


port log : String -> Cmd msg


port walletCb :
    ({ name : String
     , icon : String
     }
     -> msg
    )
    -> Sub msg


port walletTimeout : (() -> msg) -> Sub msg


port connectCb : (Maybe String -> msg) -> Sub msg


port disconnectIn : (() -> msg) -> Sub msg
