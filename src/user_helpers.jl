"""
    tern2cart(a, b, c)

Takes a point in the ternary coordinate system and returns the cartesian co-ordinate of this point.
The ternary axes are all between 0 and 1 and the cartesian co-ordinates form an equilateral triangle at (0, 0), (1, 0), (1/2, √3/2)
"""
function tern2cart(a, b, c)
    N = @. a+b+c
    x = @. 1/2 * (2b+c)/N
    y = @. √3/2 * c/N
    return (x, y)
endtern2cart(vec) = tern2cart(vec[1], vec[2], vec[3])

"""
    cart2tern(x, y)

Takes a point in the cartesian coordinate system and returns the ternary co-ordinate of this point.
"""
function cart2tern(x, y)
    c = @. (2y)/√3
    b = @. x - c/2
    a = @. 1 - b - c
    return (a, b, c)
end
cart2tern(array) = cart2tern(array[1], array[2])
