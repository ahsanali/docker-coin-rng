import os
import tempfile
import pytest
from rng import rng


@pytest.fixture
def client(request):
    rng.app.config['TESTING'] = True
    client = rng.app.test_client()
    return client

def test_rng(client):
    """Start with a blank database."""
    number_of_bytes = 32
    rv = client.get('/%s'%number_of_bytes)
    assert len(rv.data) == number_of_bytes

