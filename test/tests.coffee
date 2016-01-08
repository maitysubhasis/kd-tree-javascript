kdTree = require('../')
expect = require('expect.js')
_ = require('lodash')
WGS84Util = require('wgs84-util')
mtDiabloFC = require('./mtDiablo.json')
tree = null


describe 'kdTree', ->

   beforeEach ->
      points = _.filter mtDiabloFC.features, geometry:
         type: 'Point'
      points = _.map points, 'geometry'

      tree = new kdTree points, WGS84Util.distanceBetween.bind(WGS84Util)

   it 'should instantiate with given config', ->
      expect(tree).to.be.an(kdTree)

   describe 'nearest', ->
      it 'should return nearest point', ->
         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 1)

         expect(nearest.length).to.equal 1
         expect(nearest[0][0].coordinates[0]).to.equal -121.9175526
         expect(nearest[0][0].coordinates[1]).to.equal 37.8808685
         expect(nearest[0][1]).to.equal 11.079652147188876

      it 'should return nearest points', ->
         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 2)

         expect(nearest.length).to.equal 2
         expect(nearest[1][0].coordinates[0]).to.equal -121.9175526
         expect(nearest[1][0].coordinates[1]).to.equal 37.8808685
         expect(nearest[0][0].coordinates[0]).to.equal -121.9172383
         expect(nearest[0][0].coordinates[1]).to.equal 37.8809159

      it 'should return nearest points within maxDistance', ->
         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 10, 40)

         expect(nearest.length).to.equal 2
         expect(nearest[0][0].coordinates[0]).to.equal -121.9175526
         expect(nearest[0][0].coordinates[1]).to.equal 37.8808685
         expect(nearest[1][0].coordinates[0]).to.equal -121.9172383
         expect(nearest[1][0].coordinates[1]).to.equal 37.8809159

   describe 'insert', ->
      it 'should insert a new point', ->
         tree.insert({
            type: 'Point',
            coordinates: [-121.917737, 37.880895]
         })

         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 10, 40)

         expect(nearest.length).to.equal 3

   describe 'remove', ->
      it 'should remove an existing point', ->
         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 1)

         tree.remove(nearest[0][0])

         nearest = tree.nearest({
            type: 'Point',
            coordinates: [-121.917662, 37.880918]
         }, 10, 40)

         expect(nearest.length).to.equal 1

   describe 'balanceFactor', ->
      it 'should calculate balance factor', ->
         expect(tree.balanceFactor()).to.be.above 1

   describe 'toJSON', ->
      it 'should return tree structure in JSON object form', ->
         expect(_.isObject(tree.toJSON())).to.be true
