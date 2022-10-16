#!/usr/bin/python3
""" State Module for HBNB project """
import os
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship
from models.base_model import BaseModel, Base
from models import storage


class State(BaseModel, Base):
    """ State class """
    __tablename__ = 'states'

    name = Column(String(128))
    """cities = relationship(
            'City', back_populates='state',
            cascade='all, delete, delete-orphan')"""


if os.environ.get('HBNB_TYPE_STORAGE') == 'db':
    State.cities = relationship('City', back_populates='state',
                                cascade='all, delete, delete-orphan')
else:
    def cities(self):
        from models import storage
        State.id = self.id
        return storage.cities()
    State.cities = cities
