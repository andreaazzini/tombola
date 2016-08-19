module Utils exposing (at, selectedNumbers)

import Maybe


at : List Int -> Int -> Int
at list index =
  Maybe.withDefault 0 (List.drop index list |> List.head)

selectedNumbers : List Int -> List Int
selectedNumbers list =
  List.filter (\elem -> not (List.member elem list)) [1..90]
