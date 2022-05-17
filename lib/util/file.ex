defmodule Util.File do
  @moduledoc """
  Functions for simplifying file operations.
  """

  @doc """
  Calculate the sha256 hash of a file.
  """
  @spec calculate_hash_of_file(path :: Path.t()) ::
          {:ok, binary()} | {:error, :file_not_found}

  def calculate_hash_of_file(path) do
    if File.exists?(path) do
      {:ok, do_calculate_hash_of_file(path)}
    else
      {:error, :file_not_found}
    end
  end

  defp do_calculate_hash_of_file(path) do
    path
    |> File.stream!([], 2048)
    |> Enum.reduce(:crypto.hash_init(:sha256), &(:crypto.hash_update(&2, &1)))
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

  @doc """
  Creates a directory, including parent directories.
  """
  @spec create_dir(Path.t()) ::
          {:ok, Path.t()} | {:error, reason :: atom()}

  def create_dir(path) when is_binary(path) do
    case File.mkdir_p(path) do
      :ok   -> {:ok, path}
      error -> error
    end
  end

  @doc """
  Returns the size of the given file.
  """
  @spec get_file_size(path :: Path.t()) ::
          {:ok, integer()} | {:error, :file_not_found}

  def get_file_size(path) do
    case File.stat(path) do
      {:ok, %File.Stat{size: size}} -> {:ok, size}
      {:error, :enoent}             -> {:error, :not_found}
    end
  end

  @doc """
  Moves a file from the source path to the target path.
  """
  @spec move_file(Path.t(), Path.t(), opts :: list()) ::
          {:ok, Path.t()} | {:error, reason :: atom()}

  def move_file(source_path, target_path, opts \\ []) do
    # Make sure that the folder we want to copy into exists
    target_dir = Path.dirname(target_path)
    with {:ok, _target_dir} <- create_dir(target_dir) do
      if !File.exists?(target_path) or opts[:overwrite] do
        case File.rename(source_path, target_path) do
          :ok               -> {:ok, target_path}
          {:error, :enoent} -> {:error, :source_not_found}
        end
      else
        {:error, :target_already_exists}
      end
    end
  end

  @doc """
  Takes binary data and writes it the location specified.  It will create the
  needed subdirectories.
  """
  @spec write_to_file(data :: binary(), target_location :: Path.t()) ::
          {:ok, saved_location :: Path.t()} | {:error, reason :: atom()}

  def write_to_file(data, target_location) when not is_nil(data) do
    with :ok <- target_location |> Path.dirname() |> File.mkdir_p(),
         :ok <- File.write(target_location, data) do
      {:ok, target_location}
    end
  end

end
