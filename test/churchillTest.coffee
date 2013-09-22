churchill = require(__dirname + '/../lib/churchill')(__dirname + '/test.conf')
chai      = require 'chai'
expect    = chai.expect
fs        = require 'fs'


describe('churchill', () =>

    it('loads config from file', (done) =>
        fs.readFile(__dirname + '/test/test.conf', (err, data) =>
            if (err)
                throw err
            else
                expect(churchill.getConfig()).to.be.equal(JSON.parse(data))
            done())
    )

    it('instantiate loggers as singletons', () =>
        logger  = churchill.get('myLogger')
        logger2 = churchill.get('myLogger')
        expect(logger).to.be.an('object')
        expect(logger).to.be.equal(logger2)
    )

    it('logs according to configuration', () =>
        logger = churchill.get('myLogger')
        logger.foo("This is a red string prefixed with 'foo' and date")
    )
    
)