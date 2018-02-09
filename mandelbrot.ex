import ComplexNum
import Color

defmodule Brot do
    
    @moduledoc """
    A Mandelbrot generator module.
    """

    def mandelbrot(cr, ci, m) do
        test(1, 0, 0, cr, ci, m)
    end

    def test(i, zr, zi, cr, ci, m) do
        unless i == m do
            zr2 = zr * zr
            zi2 = zi * zi
            a2 = zr2 + zi2
            if a2 < 4.0 do
                sr = zr2 - zi2 + cr
                si = 2*zr*zi + ci
                test(i + 1, sr, si, cr, ci, m)
            else
                i
            end
        else
            0
        end
    end

    def test(i, z, c, m) do
        i = i + 1
        z = ComplexNum.add(ComplexNum.sqr(z), c)
        if ComplexNum.abs(z) >= 2 do
            i
        else
            if m > 1 do
                test(i, z, c, m - 1)
            else
                0
            end
        end
    end

end

defmodule Mandel do

    @moduledoc """
    Mandelbrot set generator.
    """

    def mandelbrot(width, height, x, y, k, depth) do
        transx = fn(w) ->
            x + k * (w - 1)
        end
        transy = fn(h) ->
            y - k * (h - 1)
        end

        rows(width, height, transx, transy, depth)
    end

    def rows(width, height, transx, transy, depth) do
        for h <- 1..height do
            for w <- 1..width do
                Color.convert(Brot.mandelbrot(transx.(w), transy.(h), depth), depth)
            end
        end
    end
end