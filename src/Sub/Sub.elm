module Sub.Sub exposing (..)

import Browser.Events as Events
import Msg.Msg exposing (Msg(..))


onResize : Sub Msg
onResize =
    Events.onResize (\w h -> NewWindowSize (Just { width = w, height = h }))
