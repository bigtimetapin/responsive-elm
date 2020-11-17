module Msg.Msg exposing (Msg(..))

import Model.WindowSize exposing (WindowSize)


type Msg
    = NewWindowSize (Maybe WindowSize)
