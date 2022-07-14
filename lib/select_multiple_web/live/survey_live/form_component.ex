defmodule SelectMultipleWeb.SurveyLive.FormComponent do
  use SelectMultipleWeb, :live_component

  alias SelectMultiple.Surveys

  @impl true
  def update(%{survey: survey} = assigns, socket) do
    IO.inspect(survey, label: "update-survey")
    changeset = Surveys.change_survey(survey)
    IO.inspect(changeset, label: "update-changeset")

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:animal_choices, Phoenix: "Phoenix", Wallaby: "Wallaby", Numbat: "Numbat")}
  end

  @impl true
  def handle_event("validate", %{"survey" => survey_params} = params, socket) do
    IO.inspect(params, label: "validate-params")
    IO.inspect(survey_params, label: "validate-survey-params")
    IO.inspect(socket.assigns.changeset, label: "validate-socket-assigns-changeset")
    socket.assigns.survey |> IO.inspect(label: "#{__MODULE__}2 sir4")

    changeset =
      socket.assigns.survey
      |> Surveys.change_survey(survey_params)
      |> Map.put(:action, :validate)

    IO.inspect(changeset, label: "validate-changeset")

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"survey" => survey_params}, socket) do
    survey_params |> IO.inspect(label: "#{__MODULE__}27")
    save_survey(socket, socket.assigns.action, survey_params)
  end

  defp save_survey(socket, :edit, survey_params) do
    case Surveys.update_survey(socket.assigns.survey, survey_params) do
      {:ok, _survey} ->
        {:noreply,
         socket
         |> put_flash(:info, "Survey updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_survey(socket, :new, survey_params) do
    survey_params |> IO.inspect(label: "#{__MODULE__}44")

    case Surveys.create_survey(survey_params) do
      {:ok, _survey} ->
        {:noreply,
         socket
         |> put_flash(:info, "Survey created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset |> IO.inspect(label: "#{__MODULE__}52")
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
