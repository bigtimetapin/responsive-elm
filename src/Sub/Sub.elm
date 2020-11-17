module Sub.Sub exposing (..)

import Browser.Events as Events
import Model.WindowSize as WindowSize
import Msg.Msg exposing (Msg(..))


onResize : Sub Msg
onResize =
    Events.onResize (\w h -> NewWindowSize (Just (WindowSize.apply w h)))
