INSERT INTO SCHEME_XREF(id, account, description)
  VALUES('PROTEKTA', 'PROTEKTA', 'PROTEKTA Medical Scheme')
GO
INSERT INTO SCHEME_XREF(id, account, description)
  VALUES('J', 'PROTEKTA', 'PROTEKTA Medical Scheme')
GO
INSERT INTO SCHEME_XREF(id, account, description)
  VALUES('P29', 'PROTEKTA', 'PROTEKTA Medical Scheme')
GO
-- The table below has a foreign-key constraint reference from GAME.dbo.USER_SCHEME
-- One may have to run the delete query included in this comment with the SCHEME_ID 
-- value from SCHEME_INFO if replacing a scheme (reusing a scheme code).
-- DELETE FROM dbo.USER_SCHEME WHERE SCHEME_ID=<SCHEME_ID FROM SCHEME_INFO>
-- GO
INSERT INTO GAME.dbo.SCHEME_INFO(Z_SUPER_SCHEME, SCHEME_DESC, SCHEME_ACCOUNT)
VALUES('J ', 'PROTEKTA                                         ', 'PROTEKTA          ')
GO