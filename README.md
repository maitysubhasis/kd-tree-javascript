[![NPM](https://nodei.co/npm/k-d-tree.png?downloads=true&stars=true)](https://nodei.co/npm/k-d-tree/)

A basic but super fast JavaScript implementation of the k-dimensional tree data structure.

In computer science, a k-d tree (short for k-dimensional tree) is a space-partitioning data structure for organizing points in a k-dimensional space. k-d trees are a useful data structure for several applications, such as searches involving a multidimensional search key (e.g. range searches and nearest neighbor searches). k-d trees are a special case of binary space partitioning trees.

Installation
-------------
    $ npm install k-d-tree

Methods
--------
    constructor(points, metric)
> Create a new tree
>
> **Parameters**
>
> **points**:  *Array*,  GeoJSON points
>
> **metric**:  *function*,  a distance function
>

    nearest(point, maxNodes, maxDistance)
> Query the nearest *maxNodes* neighbors to a point
>
> **Parameters**
>
> **point**:  *object*, GeoJSON point
>
> **maxNodes**:  *number*, maximum amount of elements to return
>
> **maxDistance**:  *number*, optional maximal search distance
>
> **Returns**
>
> *Array*, Elements with two components: the searched point and
> the distance to it


    insert(point)
> Insert a new point into the tree
>
> **Parameters**
>
> **point**:  *object*, GeoJSON point
>
> **Returns**
>
> *Node*,  reference to inserted Node instance

    remove(point)
> Remove a point from the tree by reference
>
> **Parameters**
>
> **point**:  *object*,  GeoJSON point
>
> **Returns**
>
> *Node*,  reference to removed Node instance

    balanceFactor()
> Get an approximation of how unbalanced the tree is
>
> **Returns**
>
> *number*, The higher this number, the worse query performance will be.
> It indicates how many times worse it is than the optimal tree.
> Minimum is 1. Unreliable for small trees.

    toJSON()
> Convert tree to a JSON serializable structure
>
> **Returns**
>
> *object*, JSON representation of the k-d tree


Running Tests
--------------
Install the development dependencies:

    $ npm install

Then run the tests:

    $ npm test

Code Coverage
--------------
Install the development dependencies:

    $ npm install

Then run coverage

    $ npm run coverage

View coverage reports

    $ firefox coverage/lcov-report/index.html

Browser Bundle
---------------
    $ npm run build
