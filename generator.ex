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

    @zoom_depth     64
    @zoom_width     256
    @zoom_height    256

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

    def generateAround(x, y, span, width, height, depth, name) do
        step = span / width
        x_begin = x - (span / 2)
        y_begin = y + ((span * height / width) / 2)
        img = Mandel.mandelbrot(width, height, x_begin, y_begin, step, depth)
        PPM.write(@image_path <> name <> @extension, img)
    end
    def generateAround(x, y, span, width, height, depth) when is_number(depth), do: generateAround(x, y, span, width, height, depth, @default_name)
    def generateAround(x, y, span, width, height, name) when is_binary(name), do: generateAround(x, y, span, width, height, @default_depth, name)
    def generateAround(x, y, span, width, height), do: generateAround(x, y, span, width, height, @default_depth, @default_name)
    def generateAround(x, y, span, depth) when is_number(depth), do: generateAround(x, y, span, @default_width, @default_height, depth)
    def generateAround(x, y, span, name) when is_binary(name), do: generateAround(x, y, span, @default_width, @default_height, name)
    def generateAround(x, y, span), do: generateAround(x, y, span, @default_width, @default_height)

    def zoom(m, xs, xe, zoom_factor \\ 2), do: zoom(1, m, xs, xe, zoom_factor)
    def zoom(i, m, _, _, _) when i > m, do: :ok
    def zoom(i, m, xs, xe, z) do
        generate(@zoom_width, @zoom_height, xs, xe, "anim/" <> Integer.to_string(i))
        d = (xe - xs) / z
        zoom(i + 1, m, xs + d, xe - d, z)
    end

    def zoomtest(m, xs, xe, zoom_factor \\ 2), do: zoomtest(1, m, xs, xe, zoom_factor)
    def zoomtest(i, m, xs, xe, _) when i >= m, do: generate(@zoom_width, @zoom_height, xs, xe, "zoomtest_" <> Integer.to_string(i))
    def zoomtest(i, m, xs, xe, z) do
        d = (xe - xs) / z
        zoomtest(i + 1, m, xs + d, xe - d, z)
    end

    def zoomAround(m, x, y, initial_span, final_span), do: zoomAround(0, m - 1, x, y, initial_span, final_span)
    def zoomAround(i, m, _, _, _, _) when i > m, do: :ok
    def zoomAround(i, m, x, y, is, fs) do
        # p[0.0 - 1.0]
        p = i / m
        # lerp
        s = is * (1.0 - p) + fs * p
        generateAround(x, y, s, @zoom_width, @zoom_height, @zoom_depth, "zoom/" <> Integer.to_string(i))
        zoomAround(i + 1, m, x, y, is, fs)
    end
end