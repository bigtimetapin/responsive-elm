module Sub.Sub exposing (subs)

import Msg.Msg exposing (Msg(..))


subs : Sub Msg
subs =
    Sub.batch
        []
