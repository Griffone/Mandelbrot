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

    def simple(d, m) do
        f = d / m
        range = trunc(f * 7)
        col = trunc(255 * (f * 7 - range))
        case range do
            0 ->
                {col, 0, 0}
            1 ->
                {col, col, 0}
            2 ->
                {0, col, 0}
            3 ->
                {0, col, col}
            4 ->
                {0, 0, col}
            5 ->
                {col, 0, col}
            6 ->
                {col, col, col}
            7 ->
                {col, col, col}
        end
    end

    def blueRed(d, m) do
        f = d / m
        col = trunc(255 * f)
        {col, 0, 255 - col}
    end

    def binary(d, m) do
        f = d / m
        if f >= 0.5 do
            { 255, 255, 255 }
        else
            { 0, 0, 0 }
        end
    end
end