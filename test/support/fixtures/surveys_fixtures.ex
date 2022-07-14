defmodule SelectMultiple.SurveysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SelectMultiple.Surveys` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SelectMultiple.Surveys.create_survey()

    survey
  end
end
