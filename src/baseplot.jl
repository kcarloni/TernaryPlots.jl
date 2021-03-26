using Plots
using LinearAlgebra

tern2cart(a, b, c) = (1 / 2 * (2b + c) / (a + b + c), √3 / 2 * (c / (a + b + c)))

tern2cart(array) = tern2cart(array[1], array[2], array[3])

function cart2tern(x, y)
    c = (2 * y) / √3
    b = x - c / 2
    a = 1 - b - c
    return (a, b, c)
end

cart2tern(array) = cart2tern(array[1], array[2])

function ternary_plot(plot=nothing;
    draw_arrow=false,
    title="",
    size=nothing,
    dist_from_graph::Real=0.04,
    arrow_length::Real=0.4,
    tick_length::Real=0.015,
    labels=(A = "", B = "", C = ""),
    grid_major_ticks=0.2:0.2:0.8,
    grid_major_style=:solid,
    grid_major_alpha=1,
    grid_major_linewidth=1,
    grid_major=true,
    grid_major_B=true,
    grid_major_A=true,
    grid_major_C=true,
    grid_minor=true,
    grid_minor_ticks=0.1:0.2:0.9,
    grid_minor_style=:solid,
    grid_minor_alpha=0.2,
    grid_minor_linewidth=0.5,
    grid_minor_A=true,
    grid_minor_B=true,
    grid_minor_C=true,
    ticks=true,
    tick_labels=true,
    axis_labels=true
    )

    if size === nothing
        if title == ""
            size = (580, 550)
        else
            size = (580, 570)
        end
    end

    arrow_pos = (1 - arrow_length) / 2, 1 - (1 - arrow_length) / 2
    if plot === nothing
        p = Plots.plot(
            xlims=(-0.1, 1.1),
            ylims=(-√3 / 2 * 4 * dist_from_graph, √3 / 2 * (1 + 2 * dist_from_graph)),
            xaxis=false,
            yaxis=false,
            grid=false,
            ticks=false,
            legend=false,
            title=title,
            size=size,
        )
    else
        p = Plots.plot!(
            xlims=(-0.1, 1.1),
            ylims=(-√3 / 2 * 4 * dist_from_graph, √3 / 2 * (1 + 2 * dist_from_graph)),
            xaxis=false,
            yaxis=false,
            grid=false,
            ticks=false,
            legend=false,
            title=title,
            size=size,
        )
    end

    Plots.plot!(p, [1, 0], [0, 0], colour=:black, arrow=draw_arrow)
    Plots.plot!(p, [0, 1 / 2], [0, √3 / 2], colour=:black, arrow=draw_arrow)
    Plots.plot!(p, [1 / 2, 1], [√3 / 2, 0], colour=:black, arrow=draw_arrow)

    if grid_minor
        if grid_minor_A
            for i in grid_minor_ticks
                start_point = tern2cart(1 - i, i, 0)
                end_point = tern2cart(1 - i, 0, i)
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=grid_minor_alpha, linewidth=grid_minor_linewidth, linestyle=grid_minor_style)
            end
        end
        if grid_minor_B
            for i in grid_minor_ticks
                start_point = tern2cart(0, i, 1 - i)
                end_point = tern2cart(1 - i, i, 0)
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=grid_minor_alpha, linewidth=grid_minor_linewidth, linestyle=grid_minor_style)
            end
        end
        if grid_minor_C
            for i in grid_minor_ticks
                start_point = tern2cart(1 - i, 0, i)
                end_point = tern2cart(0, 1 - i, i)
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=grid_minor_alpha, linewidth=grid_minor_linewidth, linestyle=grid_minor_style)
            end
        end
    end

    if grid_major == true
        if grid_major_A == true
            # A-Axis Grid
            for i in grid_major_ticks
                start_point = tern2cart(1 - i, i, 0)
                end_point = tern2cart(1 - i, 0, i)
                if ticks
                    tick_offset = normalize(collect(start_point .- end_point)) ./ (1 / tick_length)
                    tick_end_point = start_point .- tick_offset
                    Plots.plot!(p, [start_point[1], tick_end_point[1]], [start_point[2], tick_end_point[2]], colour=:black)
                end
                if tick_labels
                    tick_textpos = start_point .+ [0.5 * dist_from_graph * 0.8, -dist_from_graph * 0.8]
                    Plots.annotate!(p, tick_textpos[1], tick_textpos[2], Plots.text("$(round(1 - i, sigdigits=2))", 7, rotation=0))
                end
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=0.5, linewidth=0.5, linestyle=grid_major_style)
            end
        end
        if grid_major_B == true
            # B-Axis Grid
            for i in grid_major_ticks
                end_point = tern2cart(1 - i, i, 0)
                start_point = tern2cart(0, i, 1 - i)
                if ticks
                    tick_offset = normalize(collect(start_point .- end_point)) ./ (1 / tick_length)
                    tick_end_point = start_point .- tick_offset
                    Plots.plot!(p, [start_point[1], tick_end_point[1]], [start_point[2], tick_end_point[2]], colour=:black)
                end
                if tick_labels
                    tick_textpos = start_point .+ [0.5 * dist_from_graph * 0.8, dist_from_graph * 0.8]
                    Plots.annotate!(p, tick_textpos[1], tick_textpos[2], Plots.text("$i", 7, rotation=0))
                end
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=0.5, linewidth=0.5, linestyle=grid_major_style)
                
            end
        end
        # C-Axis Grid
        if grid_major_C
            for i in grid_major_ticks
                start_point = tern2cart(1 - i, 0, i)
                end_point = tern2cart(0, 1 - i, i)
                if ticks
                    tick_offset = normalize(collect(start_point .- end_point)) ./ (1 / tick_length)
                    tick_end_point = start_point .- tick_offset
                    Plots.plot!(p, [start_point[1], tick_end_point[1]], [start_point[2], tick_end_point[2]], colour=:black)
                end
                if tick_labels
                    tick_textpos = start_point .+ [-dist_from_graph * 0.8, 0]
                    Plots.annotate!(p, tick_textpos[1], tick_textpos[2], Plots.text("$i", 7, rotation=0))
                end
                Plots.plot!(p, [start_point[1], end_point[1]], [start_point[2], end_point[2]], colour=:black, alpha=0.5, linewidth=0.5, linestyle=grid_major_style)
                
            end
        end
    end

    ## Axis labels
    if axis_labels
        # C axis
        pos =
            collect(tern2cart(arrow_pos[2], 0, arrow_pos[1])) .+
            (2 .* [-dist_from_graph, dist_from_graph])
        pos2 =
            collect(tern2cart(arrow_pos[1], 0, arrow_pos[2])) .+
            (2 .* [-dist_from_graph, dist_from_graph])
        textpos = ((pos .+ pos2) ./ 2) .+ [-dist_from_graph, dist_from_graph]
        plot!(p, [pos[1], pos2[1]], [pos[2], pos2[2]], arrow=true, colour=:black)
        annotate!(p, textpos[1], textpos[2], Plots.text(labels[:C], 10, :dark, rotation=60))

        # B axis
        pos =
            collect(tern2cart(0, arrow_pos[1], arrow_pos[2])) .+
            (2 .* [dist_from_graph, dist_from_graph])
        pos2 =
            collect(tern2cart(0, arrow_pos[2], arrow_pos[1])) .+
            (2 .* [dist_from_graph, dist_from_graph])
        textpos = ((pos .+ pos2) ./ 2) .+ [dist_from_graph, dist_from_graph]
        plot!(p, [pos[1], pos2[1]], [pos[2], pos2[2]], arrow=true, colour=:black)
        annotate!(p, textpos[1], textpos[2], Plots.text(labels[:B], 10, :dark, rotation=-60))

        # A axis
        pos = collect(tern2cart(arrow_pos[1], arrow_pos[2], 0)) .+ (2 .* [0, -dist_from_graph])
        pos2 = collect(tern2cart(arrow_pos[2], arrow_pos[1], 0)) .+ (2 .* [0, -dist_from_graph])
        textpos = ((pos .+ pos2) ./ 2) .+ [0, -dist_from_graph]
        plot!(p, [pos[1], pos2[1]], [pos[2], pos2[2]], arrow=true, colour=:black)
        annotate!(p, textpos[1], textpos[2], Plots.text(labels[:A], 10, :dark, rotation=0))
    end

    return p
end