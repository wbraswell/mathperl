#!/usr/bin/env perl

# Fractal Christmas Tree
# Sierpinski triangles animated using SDL graphics

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.007_000;

# [[[ INCLUDES ]]]
use MathPerl::Fractal::ChristmasTree;

# [[[ OPERATIONS ]]]
MathPerl::Fractal::ChristmasTree::generate_fractal__render_animation();
