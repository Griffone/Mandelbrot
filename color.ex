defmodule Color do
    
    @moduledoc """
    A Depth-to-color translation module.
    """
    def convert(depth, max) do
        red(depth, max)
    end

    def grayscale(d, m) do
        fr = d / m
        col = trunc(fr*255)
        { col, col, col }
    end

    def red(d, m) do
        f = d / m
        a = f * 4
        x = trunc(a)
        y = trunc(255 * (a - x))
        case x do
        0 ->
            {y, 0, 0}
        1 ->
            {255, y, 0}
        2 ->
            {255 - y, 255, 0}
        3 ->
            {0, 255, y}
        4 ->
            {0, 255 - y, 255}
        end
    end
end