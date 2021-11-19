defmodule Util.UUID do
  @moduledoc false

  def generate_v4_uuid do
    <<u0::48, _::4, u1::12, _::2, u2::62>> = :crypto.strong_rand_bytes(16)
    uuid_to_string(<<u0::48, 4::4, u1::12, 2::2, u2::62>>)
  end

  defp uuid_to_string(<<u0::32, u1::16, u2::16, u3::16, u4::48>>) do
    [
      Base.encode16(<<u0::32>>, case: :lower), ?-,
      Base.encode16(<<u1::16>>, case: :lower), ?-,
      Base.encode16(<<u2::16>>, case: :lower), ?-,
      Base.encode16(<<u3::16>>, case: :lower), ?-,
      Base.encode16(<<u4::48>>, case: :lower)
    ]
    |> IO.iodata_to_binary()
  end
end
