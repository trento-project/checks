This image overrides the basic corosync configuration so that it does not satisfy best practices.
Any check based on facts from `corosync.conf` gatherer should fail.
Values in `corosync.conf` are randomly generated, they have no meaning but being wrong.
