module Model exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select i ->
            { model | selected = i }

        LoadFEN m ->
            { model | position = m }


init : Model
init =
    { position = Nothing
    , selected = Nothing
    }


type Msg
    = Select (Maybe Int)
    | LoadFEN (Maybe (List String))



type alias Model =
    { position : Maybe (List String)
    , selected : Maybe Int
    }
