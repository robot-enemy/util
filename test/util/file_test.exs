defmodule Util.FileTest do
  @moduledoc false
  use ExUnit.Case
  import Util.File, only: [
    calculate_hash_of_file: 1,
    create_dir: 1,
    get_file_size: 1,
    move_file: 2,
    move_file: 3,
    write_to_file: 2,
  ]

  defp create_test_dir(%{test_dir: test_dir}) do
    create_dir(test_dir)
    :ok
  end

  defp define_test_dir(_) do
    [test_dir: Path.join(File.cwd!(), "_test")]
  end

  defp delete_test_dir_after_test(%{test_dir: test_dir}) do
    on_exit(fn -> File.rm_rf!(test_dir) end)
    :ok
  end

  describe "calculate_hash_of_file/1" do

    test "returns the correct hash" do
      file_path = Path.join(File.cwd!(), "test/data/test-image.jpg")

      assert {:ok, hash} = calculate_hash_of_file(file_path)
      assert hash == "ab246229e1659b89e32dbad5077ffa66b610c8d8ef8fc5b48c7d3d5c9ec4629e"
    end

    test "returns error tuple if files doesn't exist" do
      assert {:error, :file_not_found} = calculate_hash_of_file("~/unknown.jpg")
    end

  end

  describe "create_dir/1" do

    setup [
      :define_test_dir,
      :delete_test_dir_after_test,
    ]

    test "creates the requested directory", %{test_dir: test_dir} do
      directory_to_create = Path.join(test_dir, "make_this")

      assert {:ok, ^directory_to_create} = create_dir(directory_to_create)
      assert File.exists?(directory_to_create)
    end

    test "creates a directory mutliple levels deep", %{test_dir: test_dir} do
      directory_to_create = Path.join([test_dir, "make", "many", "levels"])

      assert {:ok, ^directory_to_create} = create_dir(directory_to_create)
      assert File.exists?(directory_to_create)
    end

    test "does not throw an error if the folder already exists", %{test_dir: test_dir} do
      directory_to_create = Path.join(test_dir, "make_this")

      assert {:ok, ^directory_to_create} = create_dir(directory_to_create)
      assert File.exists?(directory_to_create)
      assert {:ok, ^directory_to_create} = create_dir(directory_to_create)
    end

    test "returns error if the directory can't be created", %{test_dir: test_dir} do
      assert {:ok, ^test_dir} = create_dir(test_dir)

      # Create file as part of the path, stopping the folder from being created
      file_path = Path.join(test_dir, "for-error.txt")
      File.touch! file_path

      directory_to_create = Path.join(file_path, "directory-child-of-file")

      assert {:error, :enotdir} = create_dir(directory_to_create)
      refute File.exists?(directory_to_create)
    end

  end

  describe "get_file_size/1" do

    test "returns the correct file size" do
      file_path = Path.join(File.cwd!(), "test/data/test-image.jpg")

      assert {:ok, size} = get_file_size(file_path)
      assert size == 117_786
    end

    test "returns error if file doesn't exist" do
      assert {:error, :not_found} = get_file_size("unknown.file")
    end
  end

  describe "move_file/2" do

    setup [
      :define_test_dir,
      :create_test_dir,
      :delete_test_dir_after_test,
    ]

    test "moves the file from the source location to the target location", %{test_dir: test_dir} do
      source_path = Path.join(test_dir, "our-file.txt")
      target_path = Path.join(test_dir, "new-file.txt")

      # create the file
      File.touch!(source_path)

      assert {:ok, ^target_path} = move_file(source_path, target_path)
      refute File.exists?(source_path)
      assert File.exists?(target_path)
    end

    test "returns an error when the source path doesn't exist", %{test_dir: test_dir} do
      source_path = Path.join(test_dir, "our-file.txt")
      target_path = Path.join(test_dir, "new-file.txt")

      refute File.exists?(source_path)

      assert {:error, :source_not_found} = move_file(source_path, target_path)
    end

    test "returns an error if the target exists", %{test_dir: test_dir} do
      source_path = Path.join(test_dir, "our-file.txt")
      target_path = Path.join(test_dir, "new-file.txt")

      # create both source and target
      File.touch!(source_path)
      File.touch!(target_path)

      assert {:error, :target_already_exists} = move_file(source_path, target_path)
    end

    test "if the target exists, but overwrite option is passed, overwrites the file",
                                            %{test_dir: test_dir} do
      source_path = Path.join(test_dir, "our-file.txt")
      target_path = Path.join(test_dir, "new-file.txt")

      # create both source and target
      File.touch!(source_path)
      File.touch!(target_path)

      assert {:ok, ^target_path} = move_file(source_path, target_path, [overwrite: true])
      refute File.exists?(source_path)
      assert File.exists?(target_path)
    end
  end

  describe "write_to_file/2" do

    setup [
      :define_test_dir,
      :delete_test_dir_after_test,
    ]

    test "writes the given data to the given file locations", %{test_dir: test_dir} do
      data     = "TEST"
      location = Path.join(test_dir, "test.txt")

      assert {:ok, saved_location} = write_to_file(data, location)
      assert File.exists?(saved_location)
    end

    test "writes the file when target is inside a non-existing directory", %{test_dir: test_dir} do
      data = "TEST"
      sub_dirs = "many/sub/directories"
      location = Path.join([test_dir, sub_dirs, "test.txt"])

      assert {:ok, saved_location} = write_to_file(data, location)
      assert File.exists?(saved_location)
    end

    test "returns an error if the file can't be written into the target location", %{test_dir: test_dir} do
      data     = "TEST"
      sub_dir  = Path.join(test_dir, "sub-directory")
      location = Path.join(sub_dir, "test.txt")

      # Create the subdirectory as a file
      assert {:ok, _sub_dir} = write_to_file(data, sub_dir)

      # Trying to create a file inside the previously created file should fail
      assert {:error, :eexist} = write_to_file(data, location)
      refute File.exists?(location)
    end

  end

end
