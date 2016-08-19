import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)
import Random exposing (Seed)
import Result
import String
import WebSocket

import Utils


main =
  App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL

type alias Model =
  { numbers : List Int
  }

init : (Model, Cmd Msg)
init =
  (Model [1..90], Cmd.none)


-- UPDATE

type Msg
  = Extract
  | Pop Int
  | NewMessage String
  | Stop

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Extract ->
      (model, Random.generate Pop (Random.int 0 (List.length model.numbers - 1)))

    Pop index ->
      (model, WebSocket.send "ws://echo.websocket.org" (Utils.at model.numbers index |> toString))

    NewMessage popped ->
      (Model (List.filter (\elem -> elem /= Result.withDefault 0 (String.toInt popped)) model.numbers), Cmd.none)

    Stop ->
      (Model [1..90], Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://echo.websocket.org" NewMessage


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Extract ] [ text "Extract" ]
    , div [] [ text (toString (Utils.selectedNumbers model.numbers)) ]
    , button [ onClick Stop ] [ text "Stop" ]
    ]
