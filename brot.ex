import ComplexNum

defmodule Brot do
    
    @moduledoc """
    A Mandelbrot generator module.
    """

    def mandelbrot(c, m) do
        z0 = ComplexNum.new(0, 0)
        i = 0
        test(i, z0, c, m)
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