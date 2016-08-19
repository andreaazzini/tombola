var express = require('express')
  , router = express.Router();

router.get('/', function (req, res) {
  res.sendFile('admin.html', {root: './public/'});
});

module.exports = router;
