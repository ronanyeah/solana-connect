module Types exposing (..)


type alias Model =
    { walletOptions : Maybe (List WalletMeta)
    , connectInProgress : Maybe String
    , wallet : Maybe Wallet
    , isMobile : Bool
    }


type Msg
    = WalletCb WalletMeta
    | Connect String
    | ConnectCb (Maybe String)
    | Close
    | Disconnect Bool
    | DisconnectIn
    | WalletTimeout
    | Copy String


type alias Flags =
    { screen : Screen
    }


type alias Screen =
    { width : Int
    , height : Int
    }


type alias WalletMeta =
    { name : String
    , icon : String
    }


type alias Wallet =
    { address : String
    , meta : WalletMeta
    }
