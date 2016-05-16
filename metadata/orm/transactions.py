#!/usr/bin/python
"""
Transactions model
"""
from peewee import ForeignKeyField, BooleanField, Expression, OP
from metadata.rest.orm import CherryPyAPI
from metadata.orm.users import Users
from metadata.orm.proposals import Proposals
from metadata.orm.instruments import Instruments

class Transactions(CherryPyAPI):
    """
    Transactions model class
    """
    verified = BooleanField(default=False)
    submitter = ForeignKeyField(Users, related_name='transactions')
    instrument = ForeignKeyField(Instruments, related_name='transactions')
    proposal = ForeignKeyField(Proposals, related_name='transactions')

    @staticmethod
    def elastic_mapping_builder(obj):
        """
        Build the elasticsearch mapping bits
        """
        super(Transactions, Transactions).elastic_mapping_builder(obj)
        obj['verified'] = {'type': 'boolean'}
        obj['submitter'] = {'type': 'integer'}
        obj['instrument'] = {'type': 'integer'}
        obj['proposal'] = {'type': 'integer'}

    def to_hash(self):
        """
        Converts the object to a hash
        """
        obj = super(Transactions, self).to_hash()
        obj['_id'] = int(self.id)
        obj['verified'] = str(self.verified)
        obj['submitter'] = int(self.submitter.id)
        obj['instrument'] = int(self.instrument.id)
        obj['proposal'] = int(self.proposal.id)
        return obj

    def from_hash(self, obj):
        """
        Converts the hash into the object
        """
        super(Transactions, self).from_hash(obj)
        if '_id' in obj:
            # pylint: disable=invalid-name
            self.id = int(obj['_id'])
            # pylint: enable=invalid-name
        if 'submitter' in obj:
            self.submitter = Users.get(Users.id == obj['submitter'])
        if 'instrument' in obj:
            self.instrument = Instruments.get(Instruments.id == obj['instrument'])
        if 'proposal' in obj:
            self.proposal = Proposals.get(Proposals.id == obj['proposal'])
        if 'verified' in obj:
            self.verified = bool(str(obj['verified']) == "True")

    def where_clause(self, kwargs):
        """
        Where clause for the various elements.
        """
        where_clause = super(Transactions, self).where_clause(kwargs)
        if '_id' in kwargs:
            where_clause &= Expression(Transactions.id, OP.EQ, kwargs['_id'])
        if 'submitter' in kwargs:
            user = Users.get(Users.id == kwargs['submitter'])
            where_clause &= Expression(Transactions.submitter, OP.EQ, user)
        if 'instrument' in kwargs:
            inst = Instruments.get(Instruments.id == kwargs['instrument'])
            where_clause &= Expression(Transactions.instrument, OP.EQ, inst)
        if 'proposal' in kwargs:
            prop = Proposals.get(Proposals.id == kwargs['proposal'])
            where_clause &= Expression(Transactions.proposal, OP.EQ, prop)
        if 'verified' in kwargs:
            verified = bool(str(kwargs['verified']) == "True")
            where_clause &= Expression(Transactions.verified, OP.EQ, verified)
        return where_clause
