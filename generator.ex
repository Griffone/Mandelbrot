import Mandel
import PPM

defmodule Generator do
    
    @moduledoc """
    A help module that will generate an image.
    Proivdes several versions of customizeability.
    """

    @image_path     "images/"
    @default_name   "mandelbrot"
    @extension      ".ppm"
    @default_depth  64
    @default_begin  -2.125
    @default_end    1.125
    @default_width  512
    @default_height 256

    def generate(width, height, x, y, k, depth, name) do
        img = Mandel.mandelbrot(width, height, x, y, k, depth)
        PPM.write(@image_path <> name <> @extension, img)
    end
    def generate(width, height, x_begin, x_end, depth, name) when is_binary(name) do
        k = (x_end - x_begin) / width
        y = height / 2 * k
        generate(width, height, x_begin, y, k, depth, name)
    end
    def generate(width, height, x, y, k, depth) when is_number(depth), do: generate(width, height, x, y, k, depth, @default_name)
    def generate(width, height, x_begin, x_end, depth) when is_number(depth), do: generate(width, height, x_begin, x_end, depth, @default_name)
    def generate(width, height, x_begin, x_end, name) when is_binary(name), do: generate(width, height, x_begin, x_end, @default_depth, name)
    def generate(width, height, depth, name) when is_binary(name), do: generate(width, height, @default_begin, @default_end, depth, name)
    def generate(width, height, name) when is_binary(name), do: generate(width, height, @default_depth, name)
    def generate(width, height, depth) when is_number(depth), do: generate(width, height, depth, @default_name)
    def generate(width, height) when is_number(width), do: generate(width, height, @default_depth, @default_name)
    def generate(nameOrDepth), do: generate(@default_width, @default_height, nameOrDepth)
    def generate(), do: generate(@default_width, @default_height, @default_begin, @default_end, @default_depth, @default_name)

end