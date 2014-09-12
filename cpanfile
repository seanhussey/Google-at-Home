requires 'AnyEvent';
requires 'AnyEvent::Filesys::Notify';
requires 'Carp::Always';
requires 'DBIx::Class::Core';
requires 'DBIx::Class::DeploymentHandler';
requires 'DBIx::Class::Schema';
requires 'Deeme';
requires 'Deeme::Backend::Mango';
requires 'Deeme::Backend::Memory';
requires 'Deeme::Backend::SQLite';
requires 'Digest::SHA1';
requires 'Encode';
requires 'File::Find::Object';
requires 'File::Path';
requires 'Getopt::Long';
requires 'LWP::UserAgent';
requires 'Log::Any';
requires 'Log::Any::Adapter';
requires 'Mojo::Base';
requires 'Mojo::Loader';
requires 'MojoX::JSON::RPC::Service';
requires 'MojoX::JSON::RPC::Service::AutoRegister';
requires 'Mojolicious::Commands';
requires 'Mojolicious::Plugin::JsonRpcDispatcher';
requires 'Mojolicious::Plugin::BootstrapAlerts';
requires 'Mojolicious::Plugin::AssetPack';
requires 'Mojolicious::Plugin::StaticCompressor';
requires 'Mojolicious::Plugin::Bootstrap3';
requires 'Mongoose';
requires 'Mongoose::Class';
requires 'Mongoose::Document';
requires 'Moo';
requires 'Moo::Role';
requires 'MooX::Singleton';
requires 'Moose';
requires 'Moose::Role';
requires 'Net::SSH::Any';
requires 'Term::ANSIColor';
requires 'Time::HiRes';
requires 'Time::Piece';
requires 'URI';
requires 'Unix::PID';
requires 'YAML::Tiny';
requires 'feature';
requires 'forks';
requires 'namespace::autoclean';
requires 'perl', '5.010';

on configure => sub {
    requires 'ExtUtils::MakeMaker';
};

on test => sub {
    requires 'MojoX::JSON::RPC::Client';
    requires 'Test::More';
    requires 'DBD::SQLite';
};
