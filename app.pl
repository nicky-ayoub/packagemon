#!/usr/bin/perl
use strict; use warnings;
use 5.010;

use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;

  $c->render('index');
};

websocket '/echo' => sub {
  my $c = shift;

  $c->on(message => sub {
      my ($self, $msg) = @_;
      $c->app->log->debug("Received message: $msg");

      $self->send('echo: ' . $msg);
  });
};

app->start;

