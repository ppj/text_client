defmodule TextClient.Player do
  alias TextClient.{State,  Summary, Prompter, Mover}

  def play(%State{tally: %{state: :won}}) do
    exit_with_message("You won!")
  end

  def play(%State{tally: %{state: :lost}}) do
    exit_with_message("You lost.")
  end

  def play(game = %State{tally: %{state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that letter isn't in the word.")
  end

  def play(game = %State{tally: %{state: :already_used}}) do
    continue_with_message(game, "Sorry, you've already used that letter.")
  end

  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
