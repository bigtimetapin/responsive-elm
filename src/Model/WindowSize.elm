module Model.WindowSize exposing (WindowSize, apply)

import Model.Orientation exposing (Orientation(..))


type alias WindowSize =
    { width : Int
    , height : Int
    , orientation : Orientation
    }


apply : Int -> Int -> WindowSize
apply width height =
    if width < height then
        WindowSize width height Vertical

    else
        WindowSize width height Horizontal
