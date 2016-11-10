import urllib2


def test_index(base_url):
    assert 200 == urllib2.urlopen('{0}/'.format(base_url)).getcode()

def test_random_bytes(base_url):
    bytes== urllib2.urlopen('{0}/32'.format(base_url))
    assert 32 == len(bytes)