*&---------------------------------------------------------------------*
*& Report ZFORMULARIO01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zformulario01.

data: v_name type rs38l_fnam.

data: w_output type  ssfcompop,
      w_ctro   type  ssfctrlop.

parameters: p_carrid type s_carr_id,
            p_connid type	s_conn_id,
            p_fldate type	s_date,
            p_id     type	s_customer.

call function 'SSF_FUNCTION_MODULE_NAME'
  exporting
    formname = 'ZFORM001'
*   VARIANT  = ' '
*   DIRECT_CALL              = ' '
  importing
    fm_name  = v_name.

if not v_name is initial.

*  w_ctro-no_dialog = 'X'. "Não abre caixa de dialogo apresentada antes da impressão

*  w_output-tdnoprev = 'X'. "Desativa a opção de pré-visualizar
  w_output-tdimmed = 'X'.
*TDDEST

  call function v_name
    exporting
*     ARCHIVE_INDEX      =
*     ARCHIVE_INDEX_TAB  =
*     ARCHIVE_PARAMETERS =
      control_parameters = w_ctro
*     MAIL_APPL_OBJ      =
*     MAIL_RECIPIENT     =
*     MAIL_SENDER        =
      output_options     = w_output
*     USER_SETTINGS      = 'X'
      i_carrid           = p_carrid
      i_connid           = p_connid
      i_fldate           = p_fldate
      i_customid         = p_id
* IMPORTING
*     DOCUMENT_OUTPUT_INFO       =
*     JOB_OUTPUT_INFO    =
*     JOB_OUTPUT_OPTIONS =
* EXCEPTIONS
*     FORMATTING_ERROR   = 1
*     INTERNAL_ERROR     = 2
*     SEND_ERROR         = 3
*     USER_CANCELED      = 4
*     OTHERS             = 5
    .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.


endif.
