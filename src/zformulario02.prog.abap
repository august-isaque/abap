*&---------------------------------------------------------------------*
*& Report ZFORMULARIO02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zformulario02.

data: w_cabe  type zsteste001,
      t_lista type table of zsteste002.

data v_name type rs38l_fnam.

parameters: p_carrid type s_carr_id,
            p_connid type s_conn_id,
            p_fldate type s_date.

start-of-selection.

  perform f_select.

  if not t_lista[] is initial.
    perform f_smartforms.
  endif.

*&---------------------------------------------------------------------*
*& Form F_SELECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_select .

  select single a~carrid a~carrname b~connid b~countryfr b~cityfrom
         b~airpfrom b~countryto b~cityto b~airpto b~deptime c~fldate
    from scarr as a
   inner join spfli as b
      on a~carrid = b~carrid
   inner join sflight as c
      on b~carrid = c~carrid
     and b~connid = c~connid
   into w_cabe
  where c~carrid = p_carrid
    and c~connid = p_connid
    and c~fldate = p_fldate.

  if sy-subrc is initial.

    select bookid passname class luggweight wunit loccuram loccurkey
      from sbook into table t_lista
     where carrid = w_cabe-carrid
       and connid = w_cabe-connid
       and fldate = p_fldate.

  endif.

endform.

*&---------------------------------------------------------------------*
*& Form F_SMARTFORMS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_smartforms .

  call function 'SSF_FUNCTION_MODULE_NAME'
    exporting
      formname = 'ZFORM002'
    importing
      fm_name  = v_name.

  if not v_name is initial.

    call function v_name
      exporting
*       ARCHIVE_INDEX    =
*       ARCHIVE_INDEX_TAB          =
*       ARCHIVE_PARAMETERS         =
*       CONTROL_PARAMETERS         =
*       MAIL_APPL_OBJ    =
*       MAIL_RECIPIENT   =
*       MAIL_SENDER      =
*       OUTPUT_OPTIONS   =
*       USER_SETTINGS    = 'X'
        cabe             = w_cabe
*     IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO  =
*       JOB_OUTPUT_OPTIONS         =
      tables
        lista            = t_lista
      exceptions
        formatting_error = 1
        internal_error   = 2
        send_error       = 3
        user_canceled    = 4
        others           = 5.

  endif.

endform.
