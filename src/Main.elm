import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Random exposing (Seed)

import Utils

main =
  Html.program
  { init = init
  , view = view
  , subscriptions = subscriptions
  , update = update
  }


-- MODEL

type alias Model =
  { numbers : List Int
  }


-- UPDATE

type Msg
  = Extract
  | Pop Int
  | Stop

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Extract ->
      (model, Random.generate Pop (Random.int 0 (List.length model.numbers - 1)))

    Pop index ->
      (Model (List.filter (\elem -> elem /= Utils.at model.numbers index) model.numbers), Cmd.none)

    Stop ->
      (Model [1..90], Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Extract ] [ text "Extract" ]
    , div [] [ text (toString (Utils.selectedNumbers model.numbers)) ]
    , button [ onClick Stop ] [ text "Stop" ]
    ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Msg)
init =
  (Model [1..90], Cmd.none)
