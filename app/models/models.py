# app/models.py
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Package(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    tracking_number = db.Column(db.String(100), unique=True, nullable=False)
    sender_name = db.Column(db.String(100), nullable=False)
    receiver_name = db.Column(db.String(100), nullable=False)
    origin = db.Column(db.String(100), nullable=False)
    destination = db.Column(db.String(100), nullable=False)
    status = db.Column(db.String(100), nullable=False)
    current_location = db.Column(db.String(100))
    estimated_delivery_date = db.Column(db.Date)

    # Relación con TrackingEvent (uno a muchos)
    events = db.relationship('TrackingEvent', backref='package', lazy=True)

    def __repr__(self):
        return f'<Package {self.tracking_number}>'

class TrackingEvent(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    package_id = db.Column(db.Integer, db.ForeignKey('package.id', ondelete='CASCADE'), nullable=False)
    event_date = db.Column(db.DateTime, nullable=False)
    description = db.Column(db.Text, nullable=False)
    location = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f'<TrackingEvent {self.description}>'
