defmodule AgedThunder.Image do
  import UUID, only: [uuid4: 0]

  use AgedThunder.Web, :model
  use Arc.Ecto.Schema

  schema "images" do
    field :name, :string
    field :desc, :string
    field :attachment, AgedThunder.Attachment.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :desc])
    |> cast_attachments(params, [:attachment])
    |> validate_required([:name, :desc, :attachment])
  end
end
