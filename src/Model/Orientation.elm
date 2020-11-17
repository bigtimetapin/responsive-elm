module Model.Orientation exposing (Orientation(..), toString)


type Orientation
    = Horizontal
    | Vertical


toString : Orientation -> String
toString orientation =
    case orientation of
        Horizontal ->
            "Horizontal"

        Vertical ->
            "Vertical"
