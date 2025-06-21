#!/usr/bin/env perl
use Mojolicious::Lite -signatures;

get '/' => sub ($c) {
  my $name = $c->param('name') // 'World';
  $c->render(text => "Hello $name!");
};

app->start;
